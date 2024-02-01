import { AuthService } from './../../services/auth.service';
import { CommonModule, } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { FunctionService } from '../../services/function.service';
import { Function } from '../../models/function';
import { ActivatedRoute, ParamMap, Router } from '@angular/router';
import { User } from '../../models/user';

@Component({
  selector: 'app-function',
  standalone: true,
  imports: [FormsModule, CommonModule],
  templateUrl: './function.component.html',
  styleUrl: './function.component.css'
})
export class FunctionComponent implements OnInit {

  function: Function = new Function();
  nodeId: number = 0;
  fId: number = 0;
  attendees: number = 0;
  users: User[] = [];
  check: Boolean = false;



  constructor(private auth: AuthService, private funServ: FunctionService, private router: Router, private route: ActivatedRoute){}

  ngOnInit(){
    this.route.paramMap.subscribe(
      (params: ParamMap)=> {
        this.nodeId = parseInt(params.get('nId')!);
        this.fId = parseInt(params.get("fId")!);
      });
    this.loadData();
  }

  loadData(){
    this.funServ.getFunctionDetails(this.nodeId, this.fId).subscribe(
      {
        next: (funct)=>{
          this.function = funct;
          console.log(this.function)
          this.getAttendees();

        },
        error: (errors)=>{
          console.log(errors)
        }
      }
    );
  }

  getAttendees(){
    this.funServ.getAttendees(this.nodeId, this.fId).subscribe(
      {
        next: (users)=>{
          this.users = users;
          this.attendees = this.users.length;
          console.log(this.attendees)
          this.checkUser();
        },
        error: (errors)=>{
          console.log(errors)
        }
      }
    )
  }

  createNew(){
    this.router.navigateByUrl("nodes/" + this.nodeId + "/function/create")
  }

  disableFunction(){
    this.funServ.disableFunction(this.nodeId, this.fId).subscribe(
      {
        next: (funct)=>{
          this.router.navigateByUrl("nodes/"+this.nodeId)
        },
        error: (errors)=>{
          console.log(errors)
        }
      }
    )
  }

  checkUser(){
    this.auth.getLoggedInUser().subscribe(
      {
        next: (user) => {
            this.check = (this.function.user.id == user.id);
        },
        error: (errors) => {
          console.log(errors)
        }
      }
    )
  }


}
