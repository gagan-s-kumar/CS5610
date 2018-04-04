import React from 'react';
import { connect } from 'react-redux';
import { Button, FormGroup, Label, Input } from 'reactstrap';
import api from '../api';

function EditForm(params) {

  console.log("Entered EDITFORM");
  console.log(params.job[0]);
  let props = params.props;
  let job = params.job[0];
  //props.form.title = job.title;
  //props.form.description = job.description;
  //props.form.duration = job.duration;
  function update(ev) {
    let tgt = $(ev.target);

    let data = {};
    data[tgt.attr('name')] = tgt.val();
    let action = {
      type: 'UPDATE_FORM',
      data: data,
    };
    console.log(action);
    props.dispatch(action);
  }

  function edit(ev) {
    api.edit_job(props.form);
    console.log("Callin edit");
    console.log(props.form);
  }

  function clear(ev) {
    props.dispatch({
      type: 'CLEAR_FORM',
    });
  }
  let workers = _.map(props.workers, (uu) => <option key={uu.id} value={uu.id}>{uu.name}</option>);

  return <div style={{padding: "4ex"}}>
    <h2>Job Details</h2>
    <FormGroup>
      <Label for="worker_id">Worker</Label>
      <Input type="select" name="worker_id" value={props.form.worker_id} onChange={update}>
        { workers }
      </Input>
      <div class="old"> Current Assignee: { job.worker.name }</div>
    </FormGroup>
    <FormGroup>
      <Label for="title">Title</Label>
      <Input type="textarea" name="title" value={props.form.title} onChange={update} />
      <div class="old"> Current Title: { job.title }</div>
    </FormGroup>
    <FormGroup>
      <Label for="description">Description</Label>
      <Input type="textarea" name="description" value={props.form.description} onChange={update} />
      <div class="old"> Current Description: { job.description }</div>
    </FormGroup>
    <FormGroup>
      <Label for="duration">Duration</Label>
      <Input type="number" name="duration" value={props.form.duration} onChange={update} />
      <div class="old"> Current Duration: { job.duration }</div>
    </FormGroup>
    <Button onClick={edit} color="primary">Edit</Button> &nbsp;
    <Button onClick={clear}>Clear</Button>
  </div>;
}

function state2props(state) {
  console.log("rerender@EditForm", state);
  return {
    form: state.form,
    jobs: state.jobs,
  };
}

export default connect(state2props)(EditForm);

