import { Component, ElementRef, ViewChild } from '@angular/core';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-details-form',
  standalone: true,
  imports: [FormsModule],
  templateUrl: './details-form.component.html',
  styleUrl: './details-form.component.css',
})
export class DetailsFormComponent {
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
    let isValid =
      String(this.email)
        .toLowerCase()
        .match(
          /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|.(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
        ) !== null;
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
    let isValid =
      String(this.passwordOne).match(
        /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$/
      ) !== null;
    if (!isValid) {
      this.passwordOneError.nativeElement.innerHTML = `
      Password must have no spaces, a minimum of eight characters, at least one uppercase letter, one lowercase letter and one number.
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

  public validateAll(): boolean {
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
}
