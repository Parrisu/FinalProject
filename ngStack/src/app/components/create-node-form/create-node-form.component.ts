import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { Nodes } from '../../models/node';
import { NodeService } from '../../services/node.service';

@Component({
  selector: 'app-create-node-form',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './create-node-form.component.html',
  styleUrl: './create-node-form.component.css'
})
export class CreateNodeFormComponent {
  newNode = new Nodes();

  constructor(private nodeService: NodeService) {}

  addNewNode(node: Nodes) {
    this.nodeService.create(node).subscribe({
      next: (createNode) => {
        this.newNode = new Nodes();
      },
      error: (oops) => {
        console.error('NodesComponent.addNewNode: error creating new node');
        console.error(oops);
      },
    });
  }

}
