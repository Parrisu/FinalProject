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

  deleteCycle(id: number){
    if(confirm("Are you sure you want to delete your account " + this.user.firstName + "?")){
      this.userServ.destroy(id).subscribe(
        {
          next: (data)=> {
            console.log(data)
          },
          error: (errors) => {
            console.log(errors);
          }
        }
      )
    } else {
      console.log("NEVERMIND")
    }
  }

  loadData(){
    this.auth.getLoggedInUser().subscribe(
      {
        next: (user) => {
          this.user, this.editUser = user;
        },
        error: (err)=> {
          console.log(err);
        }
      }
      );
    }
}



