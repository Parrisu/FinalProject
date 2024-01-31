import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, ParamMap, Router } from '@angular/router';
import { User } from '../../models/user';
import { Nodes } from '../../models/node';
import { UserService } from '../../services/user.service';
import { NodeService } from '../../services/node.service';
import { Technology } from '../../models/technology';
import { TechnologyService } from '../../services/technology.service';
import { NgbNavModule } from '@ng-bootstrap/ng-bootstrap';
import { FunctionService } from '../../services/function.service';
import { SearchParams } from '../../models/search-params';

@Component({
  selector: 'app-search',
  standalone: true,
  imports: [NgbNavModule],
  templateUrl: './search.component.html',
  styleUrl: './search.component.css',
})
export class SearchComponent implements OnInit {
  active = 1;
  searchParams = new SearchParams();
  nodes: Nodes[] = [];
  users: User[] = [];
  technologies: Technology[] = [];

  query = '';
  stack: Technology[] = [];
  cityName = '';
  stateAbbr = '';

  constructor(
    private route: ActivatedRoute,
    private userService: UserService,
    private nodeService: NodeService,
    private funcService: FunctionService,
    private techService: TechnologyService
  ) {}

  ngOnInit(): void {
    this.route.paramMap.subscribe({
      next: (map: ParamMap) => {
        const query = map.get('query');
        console.log(`Query: ${query}`);
        if (query && !/\s/.test(query)) {
          this.refreshUsers();
          this.refreshNodes();
          this.refreshTech();
        } else {
          throw new Error('must redirect to error page');
        }
      },
    });
  }

  refreshFunctions() {
    this.funcService.searchFunctions
  }

  refreshTech() {
    this.techService.showAll().subscribe({
      next: (technologies: Technology[]) => {
        this.technologies = technologies;
      },
    });
  }

  refreshNodes() {
    this.nodeService.searchNodes(this.searchParams).subscribe({
      next: (nodes: Nodes[]) => {
        this.nodes = nodes;
      },
    });
  }

  refreshUsers() {
    this.userService.searchUsers(this.query).subscribe({
      next: (users: User[]) => {
        this.users = users;
        console.log(JSON.stringify(users));
      },
    });
  }
}
