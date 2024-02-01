import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { Router, RouterLink, RouterOutlet } from '@angular/router';
import { NgbCollapseModule, NgbDropdownModule } from '@ng-bootstrap/ng-bootstrap';
import { AuthService } from './services/auth.service';
import { PopupDisplayComponent } from './components/popup-display/popup-display.component';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [
    CommonModule,
    RouterOutlet,
    NgbCollapseModule,
    RouterLink,
    FormsModule,
    PopupDisplayComponent,
    NgbDropdownModule
  ],
  templateUrl: './app.component.html',
  styleUrl: './app.component.css',
})
export class AppComponent {
  title = 'Stack!';
  isMenuCollapsed = true;
  searchQuery = '';

  constructor(public auth: AuthService, public route: Router) {}

  search(query: string) {
    if (this.searchQuery.replace(/\s/, '') !== '') {
      const url = `/search/${query}`;
      this.route.navigateByUrl(url);
    }
  }
}
