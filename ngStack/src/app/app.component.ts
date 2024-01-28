import { Component, OnInit } from '@angular/core';
import { CommonModule, NgOptimizedImage } from '@angular/common';
import { RouterLink, RouterOutlet } from '@angular/router';
import { AuthService } from './services/auth.service';
import { NgbCollapseModule } from '@ng-bootstrap/ng-bootstrap';
import { FormsModule } from '@angular/forms';

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
export class AppComponent implements OnInit {
  title = 'Stack!';
  isMenuCollapsed = true;
  searchQuery = '';

  constructor(private auth: AuthService) {}

  ngOnInit(): void {
    // this.tempTestDeleteMeLater();
  }

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
