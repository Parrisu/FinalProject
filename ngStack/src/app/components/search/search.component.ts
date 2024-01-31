import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, ParamMap, Router } from '@angular/router';
import { User } from '../../models/user';
import { Nodes } from '../../models/node';
import { UserService } from '../../services/user.service';

@Component({
  selector: 'app-search',
  standalone: true,
  imports: [],
  templateUrl: './search.component.html',
  styleUrl: './search.component.css',
})
export class SearchComponent implements OnInit {
  nodes: Nodes[] = [];
  users: User[] = [];

  constructor(
    private route: ActivatedRoute,
    private userService: UserService
  ) {}

  ngOnInit(): void {
    this.route.paramMap.subscribe({
      next: (map: ParamMap) => {
        const query = map.get('query');
        console.log(`Query: ${query}`);
        if (query && !/\s/.test(query)) {
          this.refreshUsers(query);
        }
      },
    });
  }

  refreshUsers(query: string): void {
    this.userService.searchUsers(query).subscribe({
      next: (users: User[]) => {
        this.users = users;
        console.log(JSON.stringify(users));
      }
    });
  }
}
