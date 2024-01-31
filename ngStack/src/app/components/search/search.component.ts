import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, ParamMap, Router } from '@angular/router';
import { User } from '../../models/user';
import { Nodes } from '../../models/node';
import { UserService } from '../../services/user.service';
import { NodeSearchParams } from '../../models/node-search-params';
import { NodeService } from '../../services/node.service';
import { Technology } from '../../models/technology';
import { TechnologyService } from '../../services/technology.service';
import { NgbNavModule } from '@ng-bootstrap/ng-bootstrap';

@Component({
  selector: 'app-search',
  standalone: true,
  imports: [NgbNavModule],
  templateUrl: './search.component.html',
  styleUrl: './search.component.css',
})
export class SearchComponent implements OnInit {
  active = 1;
  nodeParams = new NodeSearchParams();
  query = '';
  nodes: Nodes[] = [];
  users: User[] = [];
  technologies: Technology[] = [];
  stack: Technology[] = [];

  constructor(
    private route: ActivatedRoute,
    private userService: UserService,
    private nodeService: NodeService,
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

  refreshTech() {
    this.techService.showAll().subscribe({
      next: (technologies: Technology[]) => {
        this.technologies = technologies;
      },
    });
  }

  refreshNodes() {
    this.nodeParams.searchQuery = this.query;
    this.nodeService.searchNodes(this.nodeParams).subscribe({
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
