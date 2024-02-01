import { AfterViewInit, Component } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-popup-display',
  standalone: true,
  imports: [],
  templateUrl: './popup-display.component.html',
  styleUrl: './popup-display.component.css',
})
export class PopupDisplayComponent implements AfterViewInit {
  popupText: string | null = null;

  constructor(private router: Router) {}

  ngAfterViewInit(): void {
    this.refresh();
    this.router.events.subscribe((event) => {
      this.refresh();
    });
  }

  refresh(): void {
    const msg = localStorage.getItem('popup-message');
    if (msg && !this.popupText) {
      this.popupText = msg;
      setTimeout(() => {
        this.clearContent();
      }, 10000);
    }
  }

  clearContent(): void {
    this.popupText = null;
    localStorage.removeItem('popup-message');
  }
}
