import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { RouterLink, RouterOutlet } from '@angular/router';
import { NgbCollapseModule } from '@ng-bootstrap/ng-bootstrap';
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
    PopupDisplayComponent
  ],
  templateUrl: './app.component.html',
  styleUrl: './app.component.css',
})
export class AppComponent {
  title = 'Stack!';
  isMenuCollapsed = true;
  searchQuery = '';

  constructor(public auth: AuthService) {}

}
