import React from 'react';
import { Card, CardBody } from 'reactstrap';
import { Button, FormGroup, Label, Input } from 'reactstrap';
import EditForm from './edit-form';
import { Link } from 'react-router-dom';

export default function Job(params) {
  let job = params.job;
  let props = params.props;
  console.log("Props@Job", params.props);
  function edit(ev) {
    return <EditForm job={job} props={props}/>;
  }
  return <Card>
    <CardBody>
      <div>
        <p>Assigned to <b>{ job.worker.name }</b></p>
        <p>Title          { job.title }</p>
        <p>Description    { job.description }</p>
        <p>Duration       { job.duration }</p>
        <p>Completed      { job.completed ? "Completed" : "No Completed"}</p>
      </div>
      <p><Link to={"/jobs/" + job.id}>Edit</Link></p>
    </CardBody>
  </Card>;
}
