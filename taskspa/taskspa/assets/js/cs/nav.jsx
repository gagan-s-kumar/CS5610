import React from 'react';
import { NavLink } from 'react-router-dom';
import { NavItem } from 'reactstrap';

export default function Nav(props) {
  return (
    <nav className="navbar navbar-dark bg-dark navbar-expand">
      <span className="navbar-brand">
        TaskSPA
      </span>
      <ul className="navbar-nav mr-auto">
        <NavItem>
          <NavLink to="/" exact={true} activeClassName="active" className="nav-link">Feed</NavLink>
        </NavItem>
        <NavItem>
          <NavLink to="/workers" href="#" className="nav-link">All Workers</NavLink>
        </NavItem>
      </ul>
      <span className="navbar-text">
        worker@host
      </span>
    </nav>
  );
}
