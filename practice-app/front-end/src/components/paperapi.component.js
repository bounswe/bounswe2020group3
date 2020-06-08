import React, { Component } from "react";
import { sendRequest } from "../helpers/requestHelper";

export default class PaperAPI extends Component {
  constructor(props) {
    super(props);
    this.state = {
      endpoint: "",
      success: null,
      message: "",
      type: "get",
      body: "",
    };
  }

  handleEndpoint = (event) => {
    this.setState({
      endpoint: event.target.value,
    });
  };

  handleBody = (event) => {
    this.setState({ body: event.target.value });
  };

  handleSubmit = (event) => {
    event.preventDefault();
    this.setState({ message: "Loading..." });
    sendRequest(this.state.endpoint, this.state.type, this.state.body)
      .then((res) => {
        console.log(res);
        return res.json();
      })
      .then((res) => {
        console.log(res);
        this.setState({ message: JSON.stringify(res, null, 2) });
        console.log(res);
      })
      .catch((err) => {
        this.setState({ message: "Error sending request !" });
        console.log(err);
      });
  };

  render() {
    return (
      <div>
        <h5 style={{ textAlign: "left" }}>Example : /api/test</h5>
        <form onSubmit={this.handleSubmit}>
          <div className="paper-api-container">
            <select
              className="custom-select paper-api-select"
              onChange={(event) => {
                this.setState({ type: event.target.value });
              }}
              defaultValue="get"
            >
              <option value="get">
                GET
              </option>
              <option value="post">POST</option>
              <option value="put">PUT</option>
              <option value="patch">PATCH</option>
              <option value="delete">DELETE</option>
            </select>
            <input
              className="form-control paper-api-input"
              type="text"
              placeholder="Endpoint"
              onChange={this.handleEndpoint}
            />
            <button type="submit" className="btn btn-primary">
              Submit
            </button>
          </div>
        </form>
        {this.state.type !== "get" && (
          <div>
            <h5 style={{ textAlign: "left" }}>Body</h5>
            <textarea
              className="form-control paper-api-body"
              type="text"
              placeholder="Body"
              onChange={this.handleBody}
            />
          </div>
        )}
        <h5>Result</h5>
        <div className="pre-scrollable paper-api-result">
          <pre>{this.state.message}</pre>
        </div>
      </div>
    );
  }
}
