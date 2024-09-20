export default function Projects() {
    return (
        <section className="project_section layout_padding">
        <div className="container">
          <div className="heading_container">
            <h2>
              Projects
            </h2>
          </div>
          <div className="carousel-wrap ">
            <div className="filter_box">
              <h6>
                Category filter
              </h6>
              <nav className="owl-filter-bar">
                <a href="#" className="item active" data-owl-filter="*">All</a>
                <a href="#" className="item" data-owl-filter=".painting">Painting</a>
                <a href="#" className="item" data-owl-filter=".reconstruction">Reconstruction </a>
                <a href="#" className="item" data-owl-filter=".repair">Repairs </a>
                <a href="#" className="item" data-owl-filter=".residential">Residential </a>
                <a href="#" className="item" data-owl-filter=".styling">Styling </a>
              </nav>
            </div>

            <div className="owl-carousel project_carousel">
              <div className="item painting">
                <div className="box">
                  <div className="img-box">
                    <img src="images/project1.jpg" alt="" />
                    <a href="" className="pin_link">
                      <i className="fa fa-link" aria-hidden="true"></i>
                    </a>
                  </div>
                  <div className="detail-box">
                    <h5>
                      Interior work
                    </h5>
                    <p>
                      alteration in some form, by injected humour, or randomised words which don't look even slightly
                      believable. If you are going to use
                    </p>
                  </div>
                </div>
              </div>
              <div className="item reconstruction">
                <div className="box">
                  <div className="img-box">
                    <img src="images/project2.jpg" alt="" />
                    <a href="" className="pin_link">
                      <i className="fa fa-link" aria-hidden="true"></i>
                    </a>
                  </div>
                  <div className="detail-box">
                    <h5>
                      Interior work
                    </h5>
                    <p>
                      alteration in some form, by injected humour, or randomised words which don't look even slightly
                      believable. If you are going to use
                    </p>
                  </div>
                </div>
              </div>
              <div className="item repair">
                <div className="box">
                  <div className="img-box">
                    <img src="images/project1.jpg" alt="" />
                    <a href="" className="pin_link">
                      <i className="fa fa-link" aria-hidden="true"></i>
                    </a>
                  </div>
                  <div className="detail-box">
                    <h5>
                      Interior work
                    </h5>
                    <p>
                      alteration in some form, by injected humour, or randomised words which don't look even slightly
                      believable. If you are going to use
                    </p>
                  </div>
                </div>
              </div>
              <div className="item residential">
                <div className="box">
                  <div className="img-box">
                    <img src="images/project1.jpg" alt="" />
                    <a href="" className="pin_link">
                      <i className="fa fa-link" aria-hidden="true"></i>
                    </a>
                  </div>
                  <div className="detail-box">
                    <h5>
                      Interior work
                    </h5>
                    <p>
                      alteration in some form, by injected humour, or randomised words which don't look even slightly
                      believable. If you are going to use
                    </p>
                  </div>
                </div>
              </div>
              <div className="item styling">
                <div className="box">
                  <div className="img-box">
                    <img src="images/project1.jpg" alt="" />
                    <a href="" className="pin_link">
                      <i className="fa fa-link" aria-hidden="true"></i>
                    </a>
                  </div>
                  <div className="detail-box">
                    <h5>
                      Interior work
                    </h5>
                    <p>
                      alteration in some form, by injected humour, or randomised words which don't look even slightly
                      believable. If you are going to use
                    </p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
    );
}