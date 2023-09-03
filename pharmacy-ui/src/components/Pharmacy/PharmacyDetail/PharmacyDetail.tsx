import React from "react";
import { Link } from "react-router-dom";
import "./PharmacyDetail.scss";

const PharmacyDetail = (props: { data: any; }) => {
  const { data } = props;
  return (
    <div className="card-item">
      <Link to={`/movie/${data.id}`}>
        <div className="card-inner">
          <div className="card-top">
            {/* <img src={data.Poster} alt={data.Title} /> */}
            <h2>{data.id}</h2>
          </div>
          <div className="card-bottom">
            <div className="card-info">
              <h4>{data.name}</h4>
              <p>{data.city}</p>
            </div>
          </div>
        </div>
      </Link>
    </div>
  );
};

export default PharmacyDetail;