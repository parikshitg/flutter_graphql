package graph

// This file will be automatically regenerated based on the schema, any resolver implementations
// will be copied through when generating and any unknown code will be moved to the end.

import (
	"context"

	"github.com/parikshitg/flutter_graphql/go-gql-server/graph/generated"
	"github.com/parikshitg/flutter_graphql/go-gql-server/graph/model"
)

var db = make(map[int]*model.Blog)

func getId(db map[int]*model.Blog) int {
	id := 0
	for k, _ := range db {
		if k > id {
			id = k
		}
	}
	return id + 1
}

func (r *mutationResolver) CreateBlog(ctx context.Context, input model.NewBlog) (*model.Blog, error) {
	blog := &model.Blog{
		ID:     getId(db),
		Title:  input.Title,
		Author: input.Author,
		Date:   input.Date,
		Body:   input.Body,
	}

	db[blog.ID] = blog

	return blog, nil
}

func (r *queryResolver) GetBlogs(ctx context.Context) ([]*model.Blog, error) {
	var blogs []*model.Blog
	for _, v := range db {
		blogs = append(blogs, v)
	}

	return blogs, nil
}

// Mutation returns generated.MutationResolver implementation.
func (r *Resolver) Mutation() generated.MutationResolver { return &mutationResolver{r} }

// Query returns generated.QueryResolver implementation.
func (r *Resolver) Query() generated.QueryResolver { return &queryResolver{r} }

type mutationResolver struct{ *Resolver }
type queryResolver struct{ *Resolver }
