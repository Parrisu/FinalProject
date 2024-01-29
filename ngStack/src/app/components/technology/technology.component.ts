import { TechnologyService } from '../../services/technology.service';
import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { Technology } from '../../models/technology';

@Component({
  selector: 'app-technology',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './technology.component.html',
  styleUrl: './technology.component.css'
})
export class TechnologyComponent implements OnInit {

  //Fields
  technologies: Technology[] = [];
  //constructor
  constructor(private technologyService: TechnologyService) {}
  //lifecycle
  ngOnInit(): void {
    this.showAllTechnologies
  }

  //methods
  showAllTechnologies(){
    this.technologyService.showAll().subscribe(
      {
        next: (technologies) => {
          this.technologies = technologies;
        },
        error: (problem) => {
          console.error('error: error loading technologies');
          console.error(problem);
        }
      }
      )
    }


}
