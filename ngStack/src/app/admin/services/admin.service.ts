import { Injectable } from '@angular/core';
import { environment } from '../../../environments/environment';
import { HttpClient } from '@angular/common/http';
import { AuthService } from '../../services/auth.service';
import { Observable, catchError, throwError } from 'rxjs';
import { Nodes } from '../../models/node';
import { User } from '../../models/user';
import { Function } from '../../models/function';

@Injectable({
  providedIn: 'root',
})
export class AdminService {
  url = `${environment.baseUrl}api/admin`;

  constructor(private http: HttpClient, private auth: AuthService) {}

  getHttpOptions() {
    let options = {
      headers: {
        Authorization: 'Basic ' + this.auth.getCredentials(),
        'X-Requested-With': 'XMLHttpRequest',
      },
    };
    return options;
  }

  getAllNodes(): Observable<Nodes[]> {
    const endpoint = `${this.url}/nodes`;
    const options = this.getHttpOptions();
    return this.http.get<Nodes[]>(endpoint, options).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error(`
            AdminService.getAllNodes(): Observable<Nodes[]>;
            error retrieving nodes ${err}`)
        );
      })
    );
  }

  setNodeStatus(nodeId: number, status: boolean): Observable<Nodes> {
    const endpoint = `${this.url}/nodes/${nodeId}?status=${status}`;
    const options = this.getHttpOptions();
    return this.http.put<Nodes>(endpoint, {}, options).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error(`
          AdminService.setNodeStatus(nodeId: number, status: boolean): Observable<Nodes>;
          error setting node status ${err}`)
        );
      })
    );
  }

  getAllUsers(): Observable<User[]> {
    const endpoint = `${this.url}/users`;
    const options = this.getHttpOptions();
    return this.http.get<User[]>(endpoint, options).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error(`
            AdminService.getAllUsers(): Observable<User[]>;
            error retrieving users ${err}`)
        );
      })
    );
  }

  setUserStatus(userId: number, status: boolean): Observable<User> {
    const endpoint = `${this.url}/users/${userId}?status=${status}`;
    const options = this.getHttpOptions();
    return this.http.put<User>(endpoint, {}, options).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error(`
          AdminService.setUserStatus(userId: number, status: boolean): Observable<User>;
          error setting user status ${err}`)
        );
      })
    );
  }

  getAllFunctions(): Observable<Function[]> {
    const endpoint = `${this.url}/functions`;
    const options = this.getHttpOptions();
    return this.http.get<Function[]>(endpoint, options).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error(`
            AdminService.getAllUsers(): Observable<Function[]>;
            error retrieving functions ${err}`)
        );
      })
    );
  }

  setFunctionStatus(functionId: number, status: boolean): Observable<Function> {
    const endpoint = `${this.url}/functions/${functionId}?status=${status}`;
    const options = this.getHttpOptions();
    return this.http.put<Function>(endpoint, {}, options).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error(`
          AdminService.setFunctionStatus(functionId: number, status: boolean): Observable<Function>;
          error setting function status ${err}`)
        );
      })
    );
  }
}
