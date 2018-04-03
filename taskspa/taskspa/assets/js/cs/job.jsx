import React from 'react';
import { Card, CardBody } from 'reactstrap';

export default function Job(params) {
  let job = params.job;
  return <Card>
    <CardBody>
      <div>
        <p>Posted by <b>{ job.worker.name }</b></p>
        <p>{ job.title }</p>
        <p>{ job.description }</p>
        <p>{ job.duration }</p>
      </div>
    </CardBody>
  </Card>;
}
