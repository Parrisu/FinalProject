import { Nodes } from './../../models/node';
import { NodeService } from '../../services/node.service';
import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';

@Component({
  selector: 'app-node',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './node.component.html',
  styleUrl: './node.component.css',
})
export class NodeComponent implements OnInit {
  //Fields
  nodeName: string = '';
  selected: Nodes | null = null;
  //constructor
  constructor(
    private nodeService: NodeService,
    private route: ActivatedRoute,
    private router: Router
  ) {}
  //lifecycle
  ngOnInit(): void {
    this.route.paramMap.subscribe({
      next: (map) => {
        const id = map.get('id');
        if (id) {
          const parse = parseInt(id) | 0;
          this.refresh(parse);
        }
      },
    });
  }

  //methods
  refresh(id: number) {
    this.nodeService.findById(id).subscribe({
      next: (node) => {
        this.selected = node;
      },
      error: () => {
        this.router.navigateByUrl('/404');
      },
    });
  }
}
