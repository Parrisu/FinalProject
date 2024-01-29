import { Component, OnInit } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { User } from '../../models/user';
import { AuthService } from '../../services/auth.service';
import { RouterLink } from '@angular/router';

@Component({
  selector: 'app-profile',
  standalone: true,
  imports: [FormsModule, RouterLink],
  templateUrl: './profile.component.html',
  styleUrl: './profile.component.css'
})
export class ProfileComponent implements OnInit {

  user: User = new User();

  constructor(private auth: AuthService){}



  ngOnInit(): void {
   this.auth.getLoggedInUser().subscribe(
    {
      next: (user) => {
        console.log(user)
        this.user = user;
      },
      error: (err)=> {
        console.log(err);
      }
    }
   );
  }

}
