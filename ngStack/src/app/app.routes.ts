import { Routes } from '@angular/router';
import { LoginComponent } from './components/login/login.component';
import { HomeComponent } from './components/home/home.component';
import { SignupComponent } from './components/signup/signup.component';
import { NodeComponent } from './components/node/node.component';
import { TechnologyComponent } from './components/technology/technology.component';
import { ProfileComponent } from './components/profile/profile.component';
import { AccountComponent } from './components/account/account.component';
import { SearchComponent } from './components/search/search.component';
import { FunctionComponent } from './components/function/function.component';
import { NotFoundPageComponent } from './components/not-found-page/not-found-page.component';
import { ErrorPageComponent } from './components/error-page/error-page.component';

export const routes: Routes = [
  { path: '', redirectTo: 'home', pathMatch: 'full' },
  { path: 'home', title: 'Home Page', component: HomeComponent },
  { path: 'login', title: 'Login Page', component: LoginComponent },
  { path: 'signup', title: 'Sign Up Page', component: SignupComponent },
  { path: 'nodes/:id', title: 'Show node', component: NodeComponent },
  {
    path: 'technologies',
    title: 'Technologies',
    component: TechnologyComponent,
  },
  { path: 'profile', title: 'Profile', component: ProfileComponent },
  { path: 'account', title: 'Account', component: AccountComponent },
  {
    path: 'search/:query',
    title: 'Search Page',
    component: SearchComponent,
  },
  { path: 'function', title: 'Account', component: FunctionComponent },
  { path: 'error', title: 'Error', component: ErrorPageComponent },
  { path: '404', title: 'not found', component: NotFoundPageComponent },
  { path: '**', redirectTo: '/404', pathMatch: 'full' },
];
