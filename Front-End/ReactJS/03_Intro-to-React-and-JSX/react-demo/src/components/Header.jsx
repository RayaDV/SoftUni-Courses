export default function Header() {
    return (
        <div className="hero_area">
        {/* header section strats */}
        <header className="header_section">
          <div className="header_top">
            <div className="container-fluid header_top_container">
              <div className="lang_box dropdown">
                <a href="#" title="Language" className="nav-link" data-toggle="dropdown" aria-expanded="true">
                  <img src="images/flag-uk.png" alt="flag" className=" " title="United Kingdom" /> <i className="fa fa-angle-down " aria-hidden="true"></i>
                </a>
                <div className="dropdown-menu ">
                  <a href="#" className="dropdown-item">
                    <img src="images/flag-france.png" className="" alt="flag" />
                  </a>
                </div>
                <span>
                  English
                </span>
              </div>
              <div className="contact_nav">
                <a href="">
                  <i className="fa fa-phone" aria-hidden="true"></i>
                  <span>
                    Call : +01 123455678990
                  </span>
                </a>
                <a href="">
                  <i className="fa fa-envelope" aria-hidden="true"></i>
                  <span>
                    Email : demo@gmail.com
                  </span>
                </a>
                <a href="">
                  <i className="fa fa-map-marker" aria-hidden="true"></i>
                  <span>
                    Location
                  </span>
                </a>
              </div>
              <div className="social_box">
                <a href="">
                  <i className="fa fa-facebook" aria-hidden="true"></i>
                </a>
                <a href="">
                  <i className="fa fa-twitter" aria-hidden="true"></i>
                </a>
                <a href="">
                  <i className="fa fa-linkedin" aria-hidden="true"></i>
                </a>
                <a href="">
                  <i className="fa fa-instagram" aria-hidden="true"></i>
                </a>
              </div>
            </div>
          </div>
          <div className="header_bottom">
            <div className="container-fluid">
              <nav className="navbar navbar-expand-lg custom_nav-container ">
                <a className="navbar-brand" href="index.html">
                  <img src="images/logo.png" alt="" />
                </a>

                <button className="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                  <span className=""> </span>
                </button>

                <div className="collapse navbar-collapse" id="navbarSupportedContent">
                  <ul className="navbar-nav  ">
                    <li className="nav-item active">
                      <a className="nav-link" href="index.html">Home <span className="sr-only">(current)</span></a>
                    </li>
                    <li className="nav-item">
                      <a className="nav-link" href="service.html">Services</a>
                    </li>
                    <li className="nav-item">
                      <a className="nav-link" href="about.html"> About</a>
                    </li>
                    <li className="nav-item">
                      <a className="nav-link" href="project.html">Project</a>
                    </li>
                    <li className="nav-item">
                      <a className="nav-link" href="testimonial.html">Testimonial</a>
                    </li>
                    <li className="nav-item">
                      <a className="nav-link" href="contact.html">Contact Us</a>
                    </li>
                    <li className="nav-item">
                      <a className="nav-link" href="#"> Login</a>
                    </li>
                    <form className="form-inline">
                      <button className="btn  my-2 my-sm-0 nav_search-btn" type="submit">
                        <i className="fa fa-search" aria-hidden="true"></i>
                      </button>
                    </form>
                  </ul>
                  <div className="quote_btn-container">
                    <a href="" className="quote_btn">
                      Get A Quote
                    </a>
                  </div>
                </div>
              </nav>
            </div>
          </div>
        </header>
        {/* end header section */}
        {/* slider section */}
        <section className="slider_section ">
          <div id="customCarousel1" className="carousel slide" data-ride="carousel">
            <div className="carousel-inner">
              <div className="carousel-item active">
                <div className="container ">
                  <div className="row">
                    <div className="col-md-10 mx-auto">
                      <div className="detail-box">
                        <h1></h1>
                        <h1>
                          ARCHITECT <br />
                          BUILDER CONSTRUCTION <br />
                          SERVICES
                        </h1>
                        <div className="btn-box">
                          <a href="" className="btn1">
                            Contact Us
                          </a>
                          <a href="" className="btn2">
                            About Us
                          </a>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <div className="carousel-item">
                <div className="container ">
                  <div className="row">
                    <div className="col-md-10 mx-auto">
                      <div className="detail-box">
                        <h1>
                          ARCHITECT <br />
                          BUILDER CONSTRUCTION <br />
                          SERVICES
                          </h1>
                        <div className="btn-box">
                          <a href="" className="btn1">
                            Contact Us
                          </a>
                          <a href="" className="btn2">
                            About Us
                          </a>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <div className="carousel-item">
                <div className="container ">
                  <div className="row">
                    <div className="col-md-10 mx-auto">
                      <div className="detail-box">
                        <h1>
                          ARCHITECT <br />
                          BUILDER CONSTRUCTION <br />
                          SERVICES
                        </h1>
                        <div className="btn-box">
                          <a href="" className="btn1">
                            Contact Us
                          </a>
                          <a href="" className="btn2">
                            About Us
                          </a>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <div className="carousel-item">
                <div className="container ">
                  <div className="row">
                    <div className="col-md-10 mx-auto">
                      <div className="detail-box">
                        <h1>
                          ARCHITECT <br />
                          BUILDER CONSTRUCTION <br />
                          SERVICES
                        </h1>
                        <div className="btn-box">
                          <a href="" className="btn1">
                            Contact Us
                          </a>
                          <a href="" className="btn2">
                            About Us
                          </a>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <div className="carousel-item">
                <div className="container ">
                  <div className="row">
                    <div className="col-md-10 mx-auto">
                      <div className="detail-box">
                        <h1>
                          ARCHITECT <br />
                          BUILDER CONSTRUCTION <br />
                          SERVICES
                        </h1>
                        <div className="btn-box">
                          <a href="" className="btn1">
                            Contact Us
                          </a>
                          <a href="" className="btn2">
                            About Us
                          </a>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <ol className="carousel-indicators">
              <li data-target="#customCarousel1" data-slide-to="0" className="active"></li>
              <li data-target="#customCarousel1" data-slide-to="1"></li>
              <li data-target="#customCarousel1" data-slide-to="2"></li>
              <li data-target="#customCarousel1" data-slide-to="3"></li>
              <li data-target="#customCarousel1" data-slide-to="4"></li>
            </ol>
          </div>

        </section>
        {/* end slider section */}
      </div>
    );
}