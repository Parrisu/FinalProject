import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterOutlet } from '@angular/router';
import { AuthService } from './services/auth.service';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [CommonModule, RouterOutlet],
  templateUrl: './app.component.html',
  styleUrl: './app.component.css',
})
export class AppComponent implements OnInit {
  title = 'Stack!';

  constructor(private auth: AuthService) {}

  ngOnInit(): void {
    this.tempTestDeleteMeLater();
  }

  tempTestDeleteMeLater(): void {
    this.auth.login('admin', 'test').subscribe({
      next: (data) => {
        console.log("Logged In:");
        console.log(JSON.stringify(data));
      },
      error: (err) => {
        console.log(err);
      },
    });
  }
}
