import { Routes } from '@angular/router';
import { LoginComponent } from './components/login/login.component';
import { HomeComponent } from './components/home/home.component';
import { SignupComponent } from './components/signup/signup.component';
import { NodeComponent } from './components/node/node.component';
import { TechnologyComponent } from './components/technology/technology.component';

export const routes: Routes = [
  { path: '', redirectTo: 'home', pathMatch: 'full' },
  { path: 'home', title: 'Home Page', component: HomeComponent },
  { path: 'login', title: 'Login Page', component: LoginComponent },
  { path: 'signup', title: 'Sign Up Page', component: SignupComponent },
  { path: 'nodes', title: 'Nodes', component: NodeComponent },
  { path: 'nodes/:name', title: 'Sign Up Page', component: NodeComponent },
  { path: 'technologies', title: 'Technologies', component: TechnologyComponent },
];
