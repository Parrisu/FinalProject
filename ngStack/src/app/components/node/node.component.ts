import { Nodes } from './../../models/node';
import { NodeService } from '../../services/node.service';
import { Component, OnInit } from '@angular/core';
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
  singleNode: Nodes | null = null;
  nodeName: string = "";
  searching: Nodes[] | null = null;
  newNode: Nodes = new Nodes();
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

    findNodesByName(id: number){
      this.nodeService.findById(id).subscribe(
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
      addNewNode(node: Nodes){
        this.nodeService.create(node).subscribe({
          next: (createNode) => {
            this.newNode = new Nodes();
            this.reload();
          },
          error: (oops) => {
            console.error('NodesComponent.addNewNode: error creating new node');
            console.error(oops);
          },
        });
      }

      reload() {
        this.nodeService.showAll().subscribe({
          next: (nodes) => {
            this.nodes = nodes;
          },
          error: (fail) => {
            console.error('Nodes.reload: error getting nodes');
          },
        });
      }
}
