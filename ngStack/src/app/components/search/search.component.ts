import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, ParamMap, Router, RouterLink } from '@angular/router';
import { User } from '../../models/user';
import { Nodes } from '../../models/node';
import { UserService } from '../../services/user.service';
import { NodeService } from '../../services/node.service';
import { Technology } from '../../models/technology';
import { TechnologyService } from '../../services/technology.service';
import { NgbNavModule } from '@ng-bootstrap/ng-bootstrap';
import { FunctionService } from '../../services/function.service';
import { SearchParams } from '../../models/search-params';
import { Function } from '../../models/function';
import { FormsModule } from '@angular/forms';
import { NotInPipe } from '../../pipes/not-in.pipe';

@Component({
  selector: 'app-search',
  standalone: true,
  imports: [NgbNavModule, FormsModule, NotInPipe, RouterLink],
  templateUrl: './search.component.html',
  styleUrl: './search.component.css',
})
export class SearchComponent implements OnInit {
  active = 1;
  nodes: Nodes[] = [];
  users: User[] = [];
  technologies: Technology[] = [];
  functions: Function[] = [];

  searchParams = new SearchParams();

  constructor(
    private route: ActivatedRoute,
    private router: Router,
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
          this.searchParams.searchQuery = query;
          this.refreshTech();
          this.refreshAll();
        } else {
          console.error(
            'Access of search page without set query path variable!'
          );
          this.router.navigateByUrl('/error');
        }
      },
    });
  }

  refreshAll() {
    this.refreshNodes();
    this.refreshUsers();
    this.refreshFunctions();
  }

  refreshFunctions() {
    this.funcService.searchFunctions(this.searchParams).subscribe({
      next: (funcs: Function[]) => {
        this.functions = funcs;
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
    this.nodeService.searchNodes(this.searchParams).subscribe({
      next: (nodes: Nodes[]) => {
        this.nodes = nodes;
      },
    });
  }

  refreshUsers() {
    this.userService.searchUsers(this.searchParams.searchQuery).subscribe({
      next: (users: User[]) => {
        this.users = users;
        console.log(JSON.stringify(users));
      },
    });
  }

  // ------------------------ action methods ------------------------
  pushToStack(tech: Technology) {
    if (!this.searchParams.stack.includes(tech)) {
      this.searchParams.stack.push(tech);
      this.technologies = this.technologies.filter(
        (item: Technology) => item !== tech
      );
      this.refreshAll();
    }
  }

  popFromStack(tech: Technology) {
    if (this.searchParams.stack.includes(tech)) {
      this.searchParams.stack = this.searchParams.stack.filter(
        (item) => item !== tech
      );
      this.technologies.push(tech);
      this.refreshAll();
    }
  }
}
