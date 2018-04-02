import React from 'react';
import { Card, CardBody } from 'reactstrap';

export default function Task(params) {
  let task = params.task;
  return <Card>
    <CardBody>
      <div>
        <p>Created by <b>{ task.user.name }</b></p>
        <p>{ task.title }</p>
        <p>{ task.description }</p>
      </div>
    </CardBody>
  </Card>;
}
