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
export class HomeComponent implements OnInit{
  nodeList: Nodes[] = [];

  constructor(private nodeService: NodeService, private router: Router) {}
  ngOnInit(): void {
    this.showAllNodes();
  }

  showAllNodes() {
    this.nodeService.showAll().subscribe({
      next: (nodeList) => {
        this.nodeList = nodeList;
      },
      error: (failed) => {
        console.error('nodeService.showall: error getting nodes');
      },
    });
  }
}
