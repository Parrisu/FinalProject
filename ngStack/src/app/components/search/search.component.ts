import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, ParamMap, Router } from '@angular/router';
import { User } from '../../models/user';
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
          this.refresh(query);
        }
      },
    });
  }

  refresh(query: string): void {

  }
}
