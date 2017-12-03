import { Component, TemplateRef, OnInit } from '@angular/core';
import { BsModalService } from 'ngx-bootstrap/modal';
import { BsModalRef } from 'ngx-bootstrap/modal/bs-modal-ref.service';
import { PostService } from '../post.service';

@Component({
  selector: 'app-posts',
  templateUrl: './posts.component.html',
  styleUrls: ['./posts.component.css']
})
export class PostsComponent implements OnInit {
  modalRef: BsModalRef;
  posts: any;
  postFormObj: any;

  constructor(private modalService: BsModalService,private _postService: PostService) { }

  ngOnInit() {
    this.getPosts();
  }

  getPosts() {
    this._postService.getPosts().subscribe(
      data => { this.posts = data; },
      err => console.error(err),
      () => console.log('done loading posts')
    );
  }

  openModal(template: TemplateRef<any>) {
    this.modalRef = this.modalService.show(template);
    this.postFormObj = this.getNewPost();
  }

  openEditModal(template: TemplateRef<any>, post) {
    this.modalRef = this.modalService.show(template);
    this.postFormObj = { id: post.id, title: post.title, description: post.description, created_by: post.created_by };
  }

  sendRequest() {
    if (this.postFormObj.id) {
      this.editPost();
    } else {
      this.createPost();
    }
  }

  editPost() {
    this._postService.editPost(this.postFormObj).subscribe(
      data => { this.modalRef.hide(); this.getPosts(); },
      err => console.error(err),
      () => console.log('done creating post')
    );
  }

  createPost() {
    this._postService.createPost(this.postFormObj).subscribe(
      data => { this.modalRef.hide(); this.getPosts(); },
      err => console.error(err),
      () => console.log('done creating post')
    );
  }

  getNewPost() {
    return { title: '', description: '', created_by: '' };
  }

  deletePost(post) {
    if (confirm('Are you sure?')) {
      this._postService.deletePost(post).subscribe(
        data => { this.getPosts(); },
        err => console.error(err),
        () => console.log('done creating post')
      );
    }
  }
}
