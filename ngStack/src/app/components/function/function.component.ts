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
    this.loadData(1);
  }

  fixTimes(){
    // this.function.startTime = this.datePipe.transform(this.function.startTime, 'h:mm a')!
  }

  loadData(nodeid: number){
    this.funServ.getFunctions(nodeid).subscribe(
      {
        next: (functs)=>{
          this.functions = functs;
          // this.fixTimes();
        },
        error: (errors)=>{
          console.log(errors)
        }
      }
    );
  }


}
