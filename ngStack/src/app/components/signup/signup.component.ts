import {
  AfterViewInit,
  Component,
  ElementRef,
  OnInit,
  ViewChild,
} from '@angular/core';
import { FormsModule } from '@angular/forms';
import { User } from '../../models/user';
import { AuthService } from '../../services/auth.service';
import { UserService } from '../../services/user.service';
import { Router } from '@angular/router';

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
  @ViewChild('formError') formError!: ElementRef<HTMLDivElement>;
  @ViewChild('usernameError') usernameError!: ElementRef<HTMLDivElement>;
  public username = '';
  @ViewChild('emailError') emailError!: ElementRef<HTMLDivElement>;
  public email = '';
  @ViewChild('passwordOneError') passwordOneError!: ElementRef<HTMLDivElement>;
  public passwordOne = '';
  @ViewChild('passwordTwoError') passwordTwoError!: ElementRef<HTMLDivElement>;
  public passwordTwo = '';
  showPassword = false;
  // --------------------------- End First Form Fields ---------------------------

  // --------------------------- Begin Second Form Fields ---------------------------
  @ViewChild('firstNameError') firstNameError!: ElementRef<HTMLDivElement>;
  public firstName = '';
  @ViewChild('lastNameError') lastNameError!: ElementRef<HTMLDivElement>;
  public lastName = '';
  public profileImageUrl = '';
  public aboutMe: string = '';
  // --------------------------- End Second Form Fields ---------------------------

  // --------------------------- Begin Third Form Fields ---------------------------
  @ViewChild('streetError') streetError!: ElementRef<HTMLDivElement>;
  public street = '';
  @ViewChild('zipCodeError') zipCodeError!: ElementRef<HTMLDivElement>;
  public zipCode = '';
  @ViewChild('cityError') cityError!: ElementRef<HTMLDivElement>;
  public city = '';
  // --------------------------- End Third Form Fields ---------------------------

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
    console.log(this.username);
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
    let strippedUsername = this.username.replace(/\s/g, '');
    let isValid =
      strippedUsername != '' &&
      this.username.length === strippedUsername.length;
    if (!isValid) {
      this.usernameError.nativeElement.innerHTML = `
      Username must not be blank and must contain no spaces.
      `;
    } else {
      this.usernameError.nativeElement.innerHTML = ``;
    }
    return isValid;
  }

  validateEmail(): boolean {
    let isValid = /.+@.+\..+/.test(this.email.toLowerCase());
    if (!isValid) {
      this.emailError.nativeElement.innerHTML = `
      Email is not valid.
      `;
    } else {
      this.emailError.nativeElement.innerHTML = ``;
    }
    return isValid;
  }

  validatePassword1(): boolean {
    let isValid = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/.test(
      this.passwordOne
    );
    if (!isValid) {
      this.passwordOneError.nativeElement.innerHTML = `
      Password must have no spaces, a minimum of eight characters, and have at least one letter and one number.
      `;
    } else {
      this.passwordOneError.nativeElement.innerHTML = ``;
    }
    return isValid;
  }

  validatePassword2(): boolean {
    let isValid = this.passwordOne === this.passwordTwo;
    if (!isValid) {
      this.passwordTwoError.nativeElement.innerHTML = `
      Passwords must match.
      `;
    } else {
      this.passwordTwoError.nativeElement.innerHTML = ``;
    }
    return isValid;
  }

  // ------------------------------ END FIRST SLIDE  ------------------------------

  // ------------------------------ BEGIN PROFILE FORM  ------------------------------
  validateFirstName(): boolean {
    const isValid =
      this.firstName.replace(/\s/g, '') != '' && this.firstName.length < 50;
    if (!isValid) {
      this.firstNameError.nativeElement.innerHTML = `
      First name must not be blank.
      `;
    } else {
      this.firstNameError.nativeElement.innerHTML = ``;
    }
    return isValid;
  }

  validateLastName(): boolean {
    const isValid =
      this.lastName.replace(/\s/g, '') != '' && this.firstName.length < 50;
    if (!isValid) {
      this.lastNameError.nativeElement.innerHTML = `
    Last name must not be blank.
    `;
    } else {
      this.lastNameError.nativeElement.innerHTML = ``;
    }
    return isValid;
  }

  validateProfileDetails(): boolean {
    let firstNameIsValid = this.validateFirstName();
    let lastNameIsValid = this.validateLastName();
    return firstNameIsValid && lastNameIsValid;
  }

  submitProfileForm(): void {
    if (this.validateProfileDetails()) this.nextSlide();
  }
  // ------------------------------ END PROFILE FORM  ------------------------------

  // ------------------------------ BEGIN ADDRESS FORM  ------------------------------
  validateStreet(): void {}
  validateZipCode(): void {} // TEMPORARY UNTIL CITY CONTROLLER
  validateCity(): void {}
  validateAddress(): boolean {
    return true;
  }
  // ------------------------------ END ADDRESS FORM  ------------------------------

  // ------------------------------ BEGIN GLOBAL SUBMISSION  ------------------------------

  submitForm(): void {
    if (!this.validateAddress()) {
      return;
    }
    let user = new User();
    user.username = this.username;
    user.password = this.passwordOne;
    user.email = this.email;
    user.firstName = this.firstName;
    user.lastName = this.lastName;
    user.profileImageUrl = this.profileImageUrl;
    user.aboutMe = this.aboutMe;

    this.authService.register(user).subscribe({
      next: () => {
        this.router.navigateByUrl(this.navigateOnSubmission);
      },
      error: this.onSubmissionError,
    });
  }

  // createUserAddress(user: User): void {
  //   let address = new Address();
  //   address.street = this.street;
  //   address.zipCode = this.zipCode;

  //   let city = new City();
  //   city.id = 1; // MUST BE CHANGED LATER

  //   address.city = city;

  //   this.userService.setUserAddress(user.id, address).subscribe({
  //     next: () => {
  //       this.router.navigateByUrl('/home');
  //     },
  //     error: this.onSubmissionError,
  //   });
  // }

  onSubmissionError(err: any): void {
    this.errorField.nativeElement.innerHTML = `Something went wrong...`;
  }
}
