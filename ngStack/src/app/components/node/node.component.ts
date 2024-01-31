import { Nodes } from './../../models/node';
import { NodeService } from '../../services/node.service';
import { Component, OnInit } from '@angular/core';
import { CommonModule, DatePipe } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { FunctionService } from '../../services/function.service';
import { Function } from '../../models/function';
import { User } from '../../models/user';
import { AuthService } from '../../services/auth.service';

@Component({
  selector: 'app-node',
  standalone: true,
  imports: [CommonModule, FormsModule, DatePipe],
  templateUrl: './node.component.html',
  styleUrl: './node.component.css',
})
export class NodeComponent implements OnInit {
  //Fields
  node: Nodes = new Nodes();
  functions: Function[] = [];
  members: User[] = [];
  userIsMember = false;

  //constructor
  constructor(
    private auth: AuthService,
    private nodeService: NodeService,
    private funcService: FunctionService,
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
          this.refreshNode(parse);
        }
      },
    });
  }

  //methods

  refreshNode(id: number) {
    this.nodeService.findById(id).subscribe({
      next: (node) => {
        this.node = node;
        this.refreshFunctions(id);
        this.refreshNodeMembers(id);
      },
      error: () => {
        this.router.navigateByUrl('/404');
      },
    });
  }

  refreshNodeMembers(nodeId: number) {
    this.nodeService.getAllUsersInNode(nodeId).subscribe({
      next: (users: User[]) => {
        this.members = users;
        this.auth.getLoggedInUser().subscribe({
          next: (currentUser: User) => {
            if (currentUser) {
              this.userIsMember = this.members
                .map((item) => item.id)
                .includes(currentUser.id);
            }
          },
        });
      },
    });
  }

  refreshFunctions(id: number) {
    this.funcService.getFunctions(id).subscribe({
      next: (value: Function[]) => {
        this.functions = value;
      },
    });
  }
}
