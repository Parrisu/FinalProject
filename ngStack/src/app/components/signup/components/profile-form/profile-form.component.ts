import { Component, ElementRef, ViewChild } from '@angular/core';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-profile-form',
  standalone: true,
  imports: [FormsModule],
  templateUrl: './profile-form.component.html',
  styleUrl: './profile-form.component.css',
})
export class ProfileFormComponent {

  @ViewChild('firstNameError') firstNameError!: ElementRef<HTMLDivElement>;
  public firstName = '';
  @ViewChild('lastNameError') lastNameError!: ElementRef<HTMLDivElement>;
  public lastName = '';

  public profileImageUrl = '';
  public aboutMe: string = '';

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

  public validateAll(): boolean {
    let firstNameIsValid = this.validateFirstName();
    let lastNameIsValid = this.validateLastName();
    return firstNameIsValid && lastNameIsValid;
  }
}
