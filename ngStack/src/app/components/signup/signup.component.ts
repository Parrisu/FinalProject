import { Component, ViewChild } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { DetailsFormComponent } from './components/details-form/details-form.component';
import { ProfileFormComponent } from './components/profile-form/profile-form.component';
import { AddressFormComponent } from './components/address-form/address-form.component';

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
  @ViewChild('detailsForm') detailsForm!: DetailsFormComponent;
  @ViewChild('profileForm') profileForm!: ProfileFormComponent;
  @ViewChild('addressForm') addressForm!: AddressFormComponent;

  currentSlide = 1;
  maxSlides = 3;

  previousSlide(): void {
    if (1 < this.currentSlide) this.currentSlide -= 1;
  }

  nextSlide(): void {
    if (this.currentSlide < this.maxSlides) this.currentSlide += 1;
  }

  submitForm(): void {}

  allAreValid(): boolean {
    let detailsAreValid = this.detailsForm.validateAll();
    let profileIsValid = this.profileForm.validateAll();
    let addressIsValid = this.addressForm.validateAll();
    return detailsAreValid && profileIsValid && addressIsValid;
  }
}
