import React from 'react';
import { Button, FormGroup, Label, Input } from 'reactstrap';

export default function TaskForm(params) {
  let users = _.map(params.users, (uu) => <option key={uu.id} value={uu.id}>{uu.name}</option>);
  return <div style={{padding: "4ex"}}>
    <h2>New Task</h2>
    <FormGroup>
      <Label for="user_id">User</Label>
      <Input type="select" name="user_id">
        { users }
      </Input>
    </FormGroup>
    <FormGroup>
      <Label for="title">Title</Label>
      <Input type="textarea" name="title" />
      <Label for="description">Description</Label>
      <Input type="textarea" name="description" />
      <Label for="duration">Duration</Label>
      <Input type="number" name="duration" />
    </FormGroup>
    <Button onClick={() => alert("TODO: Manage State")}>Task</Button>
  </div>;
}

