import { Component, ElementRef, ViewChild } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { User } from '../../models/user';
import { AuthService } from '../../services/auth.service';
import { UserService } from '../../services/user.service';
import { Address } from '../../models/address';
import { AddressService } from '../../services/address.service';

@Component({
  selector: 'app-signup',
  standalone: true,
  imports: [FormsModule],
  templateUrl: './signup.component.html',
  styleUrl: './signup.component.css',
})
export class SignupComponent {
  private navigateOnSubmission = '/login';

  @ViewChild('errorField') errorField!: ElementRef<HTMLDivElement>;

  // --------------------------- Begin First Form Fields ---------------------------
  usernameErrorText = '';
  emailErrorText = '';
  passwordOneErrorText = '';
  passwordTwoErrorText = '';
  firstNameErrorText = '';
  lastNameErrorText = '';

  passwordTwo = '';
  showPassword = false;
  user = new User();

  // --------------------------- Begin Third Form Fields ---------------------------
  addressFormErrorText = '';
  address = new Address();
  // --------------------------- End Third Form Fields ---------------------------

  currentSlide = 1;
  maxSlides = 3;

  constructor(
    private addressService: AddressService,
    private authService: AuthService,
    private router: Router
  ) {}

  previousSlide(): void {
    if (1 < this.currentSlide) this.currentSlide -= 1;
  }

  nextSlide(): void {
    if (this.currentSlide < this.maxSlides) this.currentSlide += 1;
  }

  // ------------------------------ BEGIN FIRST SLIDE ------------------------------

  submitFirstForm(): void {
    if (this.validateAllDetails()) this.nextSlide();
  }

  public validateAllDetails(): boolean {
    // done as let statements so that each validator will 100% run
    // logical '&&' does short circuiting
    let emailIsValid = this.validateEmail();
    let usernameIsValid = this.validateUsername();
    let passwordOneIsValid = this.validatePassword1();
    let passwordTwoIsValid = this.validatePassword2();

    let isValid =
      emailIsValid &&
      usernameIsValid &&
      passwordOneIsValid &&
      passwordTwoIsValid;
    return isValid;
  }

  validateUsername(): boolean {
    let strippedUsername = this.user.username.replace(/\s/g, '');
    let isValid =
      strippedUsername != '' &&
      this.user.username.length === strippedUsername.length;
    if (!isValid) {
      this.usernameErrorText = `
      Username must not be blank and must contain no spaces.
      `;
    } else {
      this.usernameErrorText = ``;
    }
    return isValid;
  }

  validateEmail(): boolean {
    let isValid = /.+@.+\..+/.test(this.user.email.toLowerCase());
    if (!isValid) {
      this.emailErrorText = `
      Email is not valid.
      `;
    } else {
      this.emailErrorText = ``;
    }
    return isValid;
  }

  validatePassword1(): boolean {
    let isValid = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/.test(
      this.user.password
    );
    if (!isValid) {
      this.passwordOneErrorText = `
      Password must have no spaces, a minimum of eight characters, and have at least one letter and one number.
      `;
    } else {
      this.passwordOneErrorText = ``;
    }
    return isValid;
  }

  validatePassword2(): boolean {
    let isValid = this.user.password === this.passwordTwo;
    if (!isValid) {
      this.passwordTwoErrorText = `
      Passwords must match.
      `;
    } else {
      this.passwordTwoErrorText = ``;
    }
    return isValid;
  }

  // ------------------------------ END FIRST SLIDE  ------------------------------

  // ------------------------------ BEGIN SECOND FORM  ------------------------------
  validateFirstName(): boolean {
    const isValid =
      this.user.firstName.replace(/\s/g, '') != '' && this.user.firstName.length < 50;
    if (!isValid) {
      this.firstNameErrorText = `
      First name must not be blank.
      `;
    } else {
      this.firstNameErrorText = ``;
    }
    return isValid;
  }

  validateLastName(): boolean {
    const isValid =
      this.user.lastName.replace(/\s/g, '') != '' && this.user.firstName.length < 50;
    if (!isValid) {
      this.lastNameErrorText = `
    Last name must not be blank.
    `;
    } else {
      this.lastNameErrorText = ``;
    }
    return isValid;
  }

  validateSecondForm(): boolean {
    let firstNameIsValid = this.validateFirstName();
    let lastNameIsValid = this.validateLastName();
    return firstNameIsValid && lastNameIsValid;
  }

  submitSecondForm(): void {
    if (this.validateSecondForm()) this.nextSlide();
  }
  // ------------------------------ END SECOND FORM  ------------------------------

  // ------------------------------ BEGIN THIRD FORM  ------------------------------
  submitThirdForm(): void {
    this.addressService.validateAddress(this.address).subscribe({
      next: (address: Address | null) => {
        if (address) {
          this.addressFormErrorText = '';
          this.address = address;
          this.submitForm();
        } else {
          this.addressFormErrorText = 'Invalid address.';
        }
      },
      error: () => {
        this.addressFormErrorText = 'Something went wrong.';
      },
    });
  }

  // ------------------------------ END THIRD FORM  ------------------------------

  // ------------------------------ BEGIN GLOBAL SUBMISSION  ------------------------------

  submitForm(): void {
    console.log('in form submission');
    this.user.address = this.address;
    this.authService.register(this.user).subscribe({
      next: () => this.router.navigateByUrl(this.navigateOnSubmission),
      error: this.onSubmissionError,
    });
  }

  onSubmissionError(err: any): void {
    this.errorField.nativeElement.innerHTML = `Something went wrong...`;
  }
}
