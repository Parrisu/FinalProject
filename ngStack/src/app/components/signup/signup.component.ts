import { Component, ElementRef, ViewChild } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { Address } from '../../models/address';
import { User } from '../../models/user';
import { AuthService } from '../../services/auth.service';
import { UserService } from '../../services/user.service';
import { City } from './../../models/city';
import { AddressFormComponent } from './components/address-form/address-form.component';
import { DetailsFormComponent } from './components/details-form/details-form.component';
import { ProfileFormComponent } from './components/profile-form/profile-form.component';
import { Router } from '@angular/router';

@Component({
  selector: 'app-signup',
  standalone: true,
  imports: [
    FormsModule,
    DetailsFormComponent,
    ProfileFormComponent,
    AddressFormComponent,
  ],
  templateUrl: './signup.component.html',
  styleUrl: './signup.component.css',
})
export class SignupComponent {
  @ViewChild('errorField') errorField!: ElementRef<HTMLDivElement>;
  @ViewChild('detailsForm') detailsForm!: DetailsFormComponent;
  @ViewChild('profileForm') profileForm!: ProfileFormComponent;
  @ViewChild('addressForm') addressForm!: AddressFormComponent;

  currentSlide = 1;
  maxSlides = 3;

  constructor(
    private authService: AuthService,
    private userService: UserService,
    private router: Router
  ) {}

  previousSlide(): void {
    if (1 < this.currentSlide) this.currentSlide -= 1;
  }

  nextSlide(): void {
    if (this.currentSlide < this.maxSlides) this.currentSlide += 1;
  }

  allAreValid(): boolean {
    let detailsAreValid = this.detailsForm.validateAll();
    let profileIsValid = this.profileForm.validateAll();
    let addressIsValid = this.addressForm.validateAll();
    return detailsAreValid && profileIsValid && addressIsValid;
  }

  submitForm(): void {
    if (!this.allAreValid()) {
      return;
    }
    let user = new User();
    user.username = this.detailsForm.username;
    user.password = this.detailsForm.passwordOne;
    user.email = this.detailsForm.email;
    user.firstName = this.profileForm.firstName;
    user.lastName = this.profileForm.lastName;
    user.profileImageUrl = this.profileForm.profileImageUrl;
    user.aboutMe = this.profileForm.aboutMe;

    this.authService.register(user).subscribe({
      next: this.createUserAddress,
      error: this.onSubmissionError,
    });
  }

  createUserAddress(user: User): void {
    let address = new Address();
    address.street = this.addressForm.street;
    address.zipCode = this.addressForm.zipCode;

    let city = new City();
    city.id = 1; // MUST BE CHANGED LATER

    address.city = city;

    this.userService.setUserAddress(user.id, address).subscribe({
      next: () => {
        this.router.navigateByUrl('/home');
      },
      error: this.onSubmissionError,
    });
  }

  onSubmissionError(err: any): void {
    this.errorField.nativeElement.innerHTML = `Something went wrong...`;
  }
}
