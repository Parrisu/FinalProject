import { Component, OnInit } from '@angular/core';
import { Nodes } from '../models/node';
import { User } from '../models/user';
import { AdminService } from './services/admin.service';
import { AuthService } from '../services/auth.service';
import { Router } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { Function } from '../models/function';

@Component({
  selector: 'app-admin',
  standalone: true,
  imports: [FormsModule],
  templateUrl: './admin.component.html',
  styleUrl: './admin.component.css',
})
export class AdminComponent implements OnInit {
  nodes: Nodes[] = [];

  users: User[] = [];
  functions: Function[] = [];

  constructor(
    private admin: AdminService,
    private auth: AuthService,
    private router: Router
  ) {}

  ngOnInit(): void {
    if (!this.auth.isAdmin) {
      this.router.navigateByUrl('/home');
    } else {
      this.refreshAll();
    }
  }

  refreshAll(): void {
    this.refreshNodes();
    this.refreshUsers();
    this.refreshFunctions();
  }

  refreshNodes(): void {
    this.admin.getAllNodes().subscribe({
      next: (nodes: Nodes[]) => {
        this.nodes = nodes;
      },
    });
  }

  setNodeStatus(node: Nodes) {
    this.admin.setNodeStatus(node.id, node.enabled).subscribe();
  }

  refreshUsers(): void {
    this.admin.getAllUsers().subscribe({
      next: (users: User[]) => {
        this.users = users;
      },
    });
  }

  setUserStatus(user: User) {
    this.admin.setUserStatus(user.id, user.enabled).subscribe();
  }

  refreshFunctions(): void {
    this.admin.getAllFunctions().subscribe({
      next: (funcs: Function[]) => {
        this.functions = funcs;
      },
    });
  }

  setFunctionStatus(func: Function) {
    this.admin.setFunctionStatus(func.id, func.enabled).subscribe();
  }
}
