import { Component, OnInit } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { User } from '../../models/user';
import { HttpClient } from '@angular/common/http';
import { AuthService } from '../../services/auth.service';
import { RouterLink } from '@angular/router';
import { UserService } from '../../services/user.service';

@Component({
  selector: 'app-account',
  standalone: true,
  imports: [FormsModule, RouterLink],
  templateUrl: './account.component.html',
  styleUrl: './account.component.css'
})
export class AccountComponent implements OnInit {
  user: User = new User();
  editUser: User = new User();

  constructor(private auth: AuthService, private userServ: UserService, private http: HttpClient){}

  ngOnInit(): void {
    this.loadData();
  }

  updateUser(user: User){
    console.log('here')
    this.userServ.updateUser(user).subscribe(
      {
        next: (user) => {
          this.user, this.editUser = user;
        },
        error: (err) => {
          console.log(err)
        }
      }
    );
    this.loadData();


  }

  loadData(){
    this.auth.getLoggedInUser().subscribe(
      {
        next: (user) => {
          console.log(user)
          this.user, this.editUser = user;
        },
        error: (err)=> {
          console.log(err);
        }
      }
      );
    }
}



