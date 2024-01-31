import { Address } from './../../models/address';
import { FunctionService } from './../../services/function.service';
import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { Function } from '../../models/function';
import { User } from '../../models/user';
import { AuthService } from '../../services/auth.service';
import { ActivatedRoute, ParamMap } from '@angular/router';

@Component({
  selector: 'app-create-function-form',
  standalone: true,
  imports: [FormsModule, CommonModule],
  templateUrl: './create-function-form.component.html',
  styleUrl: './create-function-form.component.css'
})
export class CreateFunctionFormComponent implements OnInit {

  function: Function = new Function();
  address: Address = new Address();
  currentUser: User = new User();
  nodeId: number = 0;

  constructor(private funService: FunctionService, private auth: AuthService, private route: ActivatedRoute){}

  ngOnInit(): void {
    this.route.paramMap.subscribe(
      (params: ParamMap)=> {
        this.nodeId = parseInt(params.get('id')!);
      });
    this.getUser();

  }

  addEvent(newFunction: Function){
    this.funService.createFunction(this.nodeId, newFunction).subscribe(
      {
        next: (something)=>{
          console.log(something);
        },
        error: (errors)=>{
          console.log(errors);
        }
      }
    )

  }


  getUser(){
    this.auth.getLoggedInUser().subscribe(
      {
        next: (user)=>{
          this.currentUser = user;
          console.log(this.currentUser)
          this.currentUser.id = 2;
          this.function.user = this.currentUser;
        },
        error: (errors)=>{
          console.log(errors);
        }
      }
    )
  }

}
