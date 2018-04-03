import React from 'react';
import { Button, FormGroup, Label, Input } from 'reactstrap';

export default function JobForm(params) {
  let workers = _.map(params.workers, (uu) => <option key={uu.id} value={uu.id}>{uu.name}</option>);
  return <div style={{padding: "4ex"}}>
    <h2>New Job</h2>
    <FormGroup>
      <Label for="worker_id">Worker</Label>
      <Input type="select" name="worker_id">
        { workers }
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
    <Button onClick={() => alert("TODO: Manage State")}>Job</Button>
  </div>;
}
