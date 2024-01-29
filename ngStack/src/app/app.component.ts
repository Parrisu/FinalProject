import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { RouterLink, RouterOutlet } from '@angular/router';
import { NgbCollapseModule } from '@ng-bootstrap/ng-bootstrap';
import { AuthService } from './services/auth.service';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [
    CommonModule,
    RouterOutlet,
    NgbCollapseModule,
    RouterLink,
    FormsModule,
  ],
  templateUrl: './app.component.html',
  styleUrl: './app.component.css',
})
export class AppComponent {
  title = 'Stack!';
  isMenuCollapsed = true;
  searchQuery = '';

  constructor(public auth: AuthService) {}

  // tempTestDeleteMeLater(): void {
  //   this.auth.login('admin', 'password123').subscribe({
  //     next: (data) => {
  //       console.log('Logged In:');
  //       console.log(JSON.stringify(data));
  //     },
  //     error: (err) => {
  //       console.log(err);
  //     },
  //   });
  // }
}
