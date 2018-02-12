import React from 'react';
import ReactDOM from 'react-dom';
import { Button } from 'reactstrap';

export default function game_init(root, channel) {
  ReactDOM.render(<MemoryGame channel={channel} />, root);
}

class MemoryGame extends React.Component {
  constructor(props) {
    super(props);
    this.channel = props.channel;
    this.state = { skel: "", goods: [], bads: [], max: 10, 
                   cards: [],
                   clicks: 0,
                   score: 0,
		   previous_card: "",
                totalMatches:  0,
		lockScreen: false  };

    this.channel.join()
        .receive("ok", this.gotView.bind(this))
        .receive("error", resp => { console.log("Unable to join", resp) });
  }

  gotView(view) {
    console.log("New view", view);
    this.setState(view.game);
  }

  change(pos) {
    this.flip(pos)
    this.flop(pos)
  }

  flip(pos) {
    this.channel.push("flip", { pos: pos })
        .receive("ok", this.gotView.bind(this));
  }

  flop(pos) {
    this.channel.push("flop", { pos: pos })
        .receive("ok", this.gotView.bind(this));
  }

  reset(cardlist) {
    this.channel.push("reset", { cardlist: cardlist })
        .receive("ok", this.gotView.bind(this));
  }

  render() {
    return (
      <div className="container">
 		<div className="row">
			<div className="col-md">
				<Card root={this} pos={0} />	
			</div>
			<div className="col-md">
				<Card root={this} pos={1} />	
			</div>
			<div className="col-md">
				<Card root={this} pos={2} />	
			</div>
			<div className="col-md">
				<Card root={this} pos={3} />	
			</div>
		</div>
 		<div className="row">
			<div className="col-md">
				<Card root={this} pos={4} />	
			</div>
			<div className="col-md">
				<Card root={this} pos={5} />	
			</div>
			<div className="col-md">
				<Card root={this} pos={6} />	
			</div>
			<div className="col-md">
				<Card root={this} pos={7} />	
			</div>
		</div>
 		<div className="row">
			<div className="col-md">
				<Card root={this} pos={8} />	
			</div>
			<div className="col-md">
				<Card root={this} pos={9} />	
			</div>
			<div className="col-md">
				<Card root={this} pos={10} />	
			</div>
			<div className="col-md">
				<Card root={this} pos={11} />	
			</div>
		</div>
 		<div className="row">
			<div className="col-md">
				<Card root={this} pos={12} />	
			</div>
			<div className="col-md">
				<Card root={this} pos={13} />	
			</div>
			<div className="col-md">
				<Card root={this} pos={14} />	
			</div>
			<div className="col-md">
				<Card root={this} pos={15} />	
			</div>
		</div>
		<button type="button" onClick={() => this.reset(_.shuffle(this.state.cards))}>Reset</button>
		<h1>Score</h1>
		<h1 id="score">{this.state.score}</h1>
      </div>
    );
  }
}

function Card(params){
  if(params.root.state.cards.length != 0) {
	if(params.root.state.cards[params.pos].face == true && params.root.state.cards[params.pos].match == false){
		let ele = params.root.state.cards[params.pos].value;
		return	<div className="card" onClick={() => params.root.change(params.pos)}>
			{ele}</div>
	} else if(params.root.state.cards[params.pos].match == true){
                let ele = params.root.state.cards[params.pos].value;
                return  <div className="donecard">
                        {ele}</div>
	} else{
		return	<div className="closecard" onClick={() => params.root.change(params.pos)}>
		Click Me </div>;
	}
  } else {
		return <div> Loading </div>
  }
}

