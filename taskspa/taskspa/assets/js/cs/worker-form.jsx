import React from 'react';
import { connect } from 'react-redux';
import { Button, FormGroup, Label, Input } from 'reactstrap';
import api from '../api';

function WorkerForm(props) {
  //console.log("props@JobForm", props);

  function update(ev) {
    let tgt = $(ev.target);

    let data = {};
    data[tgt.attr('name')] = tgt.val();
    let action = {
      type: 'UPDATE_FORM',
      data: data,
    };
    //console.log(action);
    props.dispatch(action);
  }

  function submit(ev) {
    api.submit_worker(props.form);
    //console.log(props.form);
  }

  function clear(ev) {
    props.dispatch({
      type: 'CLEAR_FORM',
    });
  }

  return <div style={{padding: "4ex"}}>
    <h2>New Worker</h2>
    <FormGroup>
      <Label for="name">Worker Name</Label>
      <Input type="textarea" name="name" value={props.form.name} onChange={update} />
    </FormGroup>
    <FormGroup>
      <Label for="email">Email</Label>
      <Input type="textarea" name="email" value={props.form.email} onChange={update} />
    </FormGroup>
    <FormGroup>
      <Label for="password">Password</Label>
      <Input type="password" name="password" value={props.form.password} onChange={update} />
    </FormGroup>
    <Button onClick={submit} color="primary">Create User</Button> &nbsp;
  </div>;
}

function state2props(state) {
  //console.log("rerender@WorkerForm", state);
  return {
    form: state.form,
    workers: state.workers,
  };
}

export default connect(state2props)(WorkerForm);

