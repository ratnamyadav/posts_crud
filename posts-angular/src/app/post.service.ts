import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import {Observable} from 'rxjs/Observable';

const baseUrl = 'http://localhost:3000';

@Injectable()
export class PostService {

  constructor(private http: HttpClient) {}

  // Uses http.get() to load data from a single API endpoint
  getPosts() {
    return this.http.get(baseUrl + '/posts');
  }

  createPost(newPost) {
    return this.http.post(baseUrl + '/posts', {post: newPost});
  }

  editPost(post) {
    return this.http.patch(baseUrl + '/posts/' + post.id, {post: post});
  }

  deletePost(post) {
    return this.http.delete(baseUrl + '/posts/' + post.id);
  }
}
