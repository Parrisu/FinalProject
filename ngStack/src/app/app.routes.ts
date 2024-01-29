import { Routes } from '@angular/router';
import { LoginComponent } from './components/login/login.component';
import { HomeComponent } from './components/home/home.component';
import { SignupComponent } from './components/signup/signup.component';
import { ProfileComponent } from './components/profile/profile.component';
import { AccountComponent } from './components/account/account.component';

export const routes: Routes = [
  { path: '', redirectTo: 'home', pathMatch: 'full' },
  { path: 'home', title: 'Home Page', component: HomeComponent },
  { path: 'login', title: 'Login Page', component: LoginComponent },
  { path: 'signup', title: 'Sign Up Page', component: SignupComponent },
  { path: 'profile', title: 'Profile', component: ProfileComponent },
  { path: 'account', title: 'Account', component: AccountComponent },
];
