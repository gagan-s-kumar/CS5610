import React from 'react';
import { Card, CardBody } from 'reactstrap';
import { Button, FormGroup, Label, Input } from 'reactstrap';
import EditForm from './edit-form';
import { Link } from 'react-router-dom';
import api from '../api';

export default function Job(params) {
  let job = params.job;
  let props = params.props;
  console.log("Props@Job", params.props);
  function edit(ev) {
    return <EditForm job={job} props={props}/>;
  }
  function job_delete(ev) {
    api.delete_job(job.id);
    api.request_jobs();
  }
  return <Card>
    <CardBody>
      <div>
        <p><b>Assigned to:</b>    { job.worker.name }</p>
        <p><b>Title:</b>          { job.title }</p>
        <p><b>Description:</b>    { job.description }</p>
        <p><b>Duration:</b>       { job.duration }</p>
        <p><b>Completed:</b>      { job.completed ? "Job Completed" : "Job Open"}</p>
      </div>
      <p><Link to={"/jobs/" + job.id}>Edit</Link></p>
      <Button onClick={job_delete} color="primary">Delete</Button> &nbsp;
    </CardBody>
  </Card>;
}
