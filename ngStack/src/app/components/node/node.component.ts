import { NodeService } from '../../services/node.service';
import { Component, OnInit } from '@angular/core';
import { Nodes } from '../../models/node';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-node',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './node.component.html',
  styleUrl: './node.component.css'
})
export class NodeComponent implements OnInit {

  //Fields
  nodes: Nodes[] = [];
  //constructor
  constructor(private nodeService: NodeService) {}
  //lifecycle
  ngOnInit(): void {
    this.showAllNodes();
  }

  //methods
  showAllNodes(){
    this.nodeService.showAll().subscribe(
      {
        next: (nodes) => {
          this.nodes = nodes;
        },
        error: (problem) => {
          console.error('error: error loading technologies');
          console.error(problem);
        }
      }
      )
    }

    findNodesByName(name: string){
      this.nodeService.findByName(name).subscribe(
        {
          next: (nodes) => {
            this.nodes = nodes;
          },
          error: (problem) => {
            console.error('error: error loading technologies');
            console.error(problem);
          }
        }
        )
      }
}
