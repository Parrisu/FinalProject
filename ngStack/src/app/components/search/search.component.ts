import { Component, OnInit } from '@angular/core';
import { User } from '../../models/user';
import { ActivatedRoute, ParamMap } from '@angular/router';
import { Nodes } from '../../models/node';

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

  constructor(private route: ActivatedRoute) {}

  ngOnInit(): void {
    this.route.paramMap.subscribe({
      next: (map: ParamMap) => {
        const query = map.get('query');
        if (query && !/\s/.test(query)) {
          this.refreshUsers(query);
        }
      },
    });
  }

  refreshUsers(query: string): void {}

  refreshNodes(query: string): void {}
}
