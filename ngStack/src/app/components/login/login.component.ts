import { Component, ElementRef, OnInit, ViewChild } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { AuthService } from '../../services/auth.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-login',
  standalone: true,
  imports: [FormsModule],
  templateUrl: './login.component.html',
  styleUrl: './login.component.css',
})
export class LoginComponent implements OnInit {
  @ViewChild('errorDisplay') errorDisplay!: ElementRef<HTMLDivElement>;
  @ViewChild('usernameErrorDiv') usernameErrorDiv!: ElementRef<HTMLDivElement>;
  @ViewChild('passwordErrorDiv') passwordErrorDiv!: ElementRef<HTMLDivElement>;

  username = '';
  password = '';
  showPassword = false;

  disableForm = true;

  constructor(private auth: AuthService, private router: Router) {}

  ngOnInit(): void {
    this.timeoutForm();
  }

  private timeoutForm(): void {
    this.disableForm = true;
    setTimeout(() => {
      this.disableForm = false;
    }, 500);
  }

  submitLogin(): void {
    this.displayError(''); // reset
    if (this.verifyUsername() && this.verifyPassword()) {
      this.auth.login(this.username, this.password).subscribe({
        next: (data) => {
          console.log('Logged In:');
          console.log(JSON.stringify(data));
          this.router.navigateByUrl('/home');
        },
        error: (err) => {
          console.log(err);
          this.displayError('Incorrect Username Or Password.');
        },
      });
    }
  }

  displayError(message: string): void {
    this.errorDisplay.nativeElement.innerHTML = message;
  }

  verifyUsername(): boolean {
    const div = this.usernameErrorDiv.nativeElement;
    return this.verifyIsNotBlank(this.username, 'Username', div);
  }

  verifyPassword(): boolean {
    const div = this.passwordErrorDiv.nativeElement;
    return this.verifyIsNotBlank(this.password, 'Password', div);
  }

  private verifyIsNotBlank(
    item: string,
    fieldName: string,
    div: HTMLDivElement
  ): boolean {
    let valid = false;
    if (item.replace(/\s/g, '') === '') {
      div.innerHTML = `${fieldName} must not be blank.`;
    } else {
      div.innerHTML = '';
      valid = true;
    }
    return valid;
  }
}
