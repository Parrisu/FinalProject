import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { Router, RouterLink } from '@angular/router';
import { NodeService } from '../../services/node.service';
import { Nodes } from '../../models/node';

@Component({
  selector: 'app-home',
  standalone: true,
  imports: [CommonModule, FormsModule, RouterLink],
  templateUrl: './home.component.html',
  styleUrl: './home.component.css',
})
export class HomeComponent implements OnInit {
  nodeList: Nodes[] = [];
  nodeNodeList: Nodes[][] = [];

  constructor(private nodeService: NodeService, private router: Router) {}
  ngOnInit(): void {
    this.showAllNodes();
  }

  showAllNodes() {
    this.nodeService.showAll().subscribe({
      next: (nodeList) => {
        this.nodeList = nodeList;
        this.nodeNodeList = this.subdivideNodes(nodeList);
      },
      error: (failed) => {
        console.error('nodeService.showall: error getting nodes');
      },
    });
  }

  subdivideNodes(list: Nodes[]): Nodes[][] {
    let full: Nodes[][] = [];
    let temp: Nodes[] = [];
    for (let i = 0; i < list.length; i++) {
      if (i % 3 == 0 && i !== 0) {
        temp = [];
        full.push(temp);
      }
      temp.push(list[i]);
    }
    return full;
  }
}
