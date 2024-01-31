import { Address } from './../../models/address';
import { FunctionService } from './../../services/function.service';
import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { Function } from '../../models/function';
import { User } from '../../models/user';
import { AuthService } from '../../services/auth.service';

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
  currentNode: number = 0;

  constructor(private funService: FunctionService, private auth: AuthService){}

  ngOnInit(): void {
    this.getUser();

  }

  addEvent(newFunction: Function){
    this.funService.createFunction(1, newFunction)

  }


  getUser(){
    this.auth.getLoggedInUser().subscribe(
      {
        next: (user)=>{
          this.currentUser = user;
        },
        error: (errors)=>{
          console.log(errors);
        }
      }
    )
  }

}
