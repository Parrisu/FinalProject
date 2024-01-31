import { AuthService } from './../../services/auth.service';
import { CommonModule, } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { FunctionService } from '../../services/function.service';
import { Function } from '../../models/function';

@Component({
  selector: 'app-function',
  standalone: true,
  imports: [FormsModule, CommonModule],
  templateUrl: './function.component.html',
  styleUrl: './function.component.css'
})
export class FunctionComponent implements OnInit {

  function: Function = new Function();
  functions: Function[] = [];

  constructor(private auth: AuthService, private funServ: FunctionService){}

  ngOnInit(){
    this.loadData();
  }

  fixTimes(){
    // this.function.startTime = this.datePipe.transform(this.function.startTime, 'h:mm a')!
  }

  loadData(){
    this.funServ.getFunctions(1).subscribe(
      {
        next: (functs)=>{
          this.functions = functs;
          // this.fixTimes();
          console.log(this.functions)
          for(let i of this.functions){
            console.log(i)
          }
        },
        error: (errors)=>{
          console.log(errors)
        }
      }
    );
  }


}
